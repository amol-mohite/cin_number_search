class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  CIN_INDUSTRY_CODES = YAML.load_file(Rails.root.to_s+"/config/cin_industry_codes.yml").freeze
  CIN_STATE_CODES = YAML.load_file(Rails.root.to_s+"/config/state_codes.yml").freeze
  
  CIN_LISTING_STATUS = {'L' => 'Listed Company', 'U' => 'Unlisted Company'}.freeze
  
  CIN_OWNERSHIP = {
  'FLC' => 'Financial Lease Company as Public Limited',
	'FTC' => 'Subsidiary of a Foreign Company as Private Limited ',
	'GAP' => 'General Association Public',
	'GAT' => 'General Association Private',
	'GOI' => 'Companies owned by Government of India',
	'NPL' => 'Not-for-Profit License ',
	'PLC' => 'Public Limited ',
	'PTC' => 'Private Limited ',
	'SGC' => 'Companies owned by State Government',
	'ULL' => 'Public Limited Company with Unlimited Liability',
	'ULT' => 'Private Company with Unlimited Liability'
	}.freeze

  def get_cin_data_hash(cin_number)
  	cin_data_hash = {error: 'Please enter valid CIN Number.'}
  	if (valid_cin_number = cin_number.delete(' ')).length == 21
  	  listing_status = get_listing_status valid_cin_number[0]
  	  industry_code  = get_cin_number valid_cin_number[1..5]
	    state          = get_cin_state valid_cin_number[6..7]
	    year 	     		 = get_valid_cin_year valid_cin_number[8..11]
	    ownership      = get_cin_ownership valid_cin_number[12..14]
	    registration   = valid_cin_number[15..-1]
      return cin_data_hash if [listing_status,industry_code,state,year,ownership,registration].any?{|data| data.blank?}
      cin_data_hash = {error: false, listing_status: listing_status, industry_code: industry_code,state: state, year: year, ownership: ownership, registration: registration}
    end
    cin_data_hash
  end
  
  private 
  
  def get_listing_status(status)
	  CIN_LISTING_STATUS[status.upcase]  	
  end
  
  def get_cin_number(industry_code)
    CIN_INDUSTRY_CODES[industry_code]
  end

  def get_cin_ownership(ownership) 
    CIN_OWNERSHIP[ownership.upcase]
  end

  def get_cin_state(state_code)
  	CIN_STATE_CODES[state_code.upcase]
  end

  def get_valid_cin_year(date_str)
    is_valid = date_str.match(/^(17|20)\d{2}$/)
    date_str if is_valid && date_str.to_i <= DateTime.now.year
  end
end
