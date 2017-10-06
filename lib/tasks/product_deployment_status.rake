# require 'google/api_client'
# require 'google_drive'

namespace :deployment_sheet do
  desc 'Update the info about deployment into product deployment sheet.'
  task :update, [:row, :sheet_name, :work_sheet_name] => :environment do |t, argv|
    raise 'Required data not set please check your deploy.rb and deploy/environment.rb file.' if (argv[:sheet_name].nil? or argv[:work_sheet_name].nil?)
    puts "=============================================Updating Deployemnt Sheet started ==================================================="
    puts " 'Sr.no    | Server ip     | Rails Env     | Date/Time     | Deployed By     | Git Branch     | Commit ID' "

    DeploymentSheet.new.update_status(argv[:row], argv[:sheet_name], argv[:work_sheet_name], true)
    puts "=======================================Updating Deployemnt Sheet completed=========================================================="
  end
end


class DeploymentSheet
  CLIENT_ID = '594089154133-eobgcdp0qbgn8so8rhsojks6og0f768c.apps.googleusercontent.com'
  CLIENT_SECRET = 'GV0d5kjlmcRTNx8Kb1ZhKUqx'
  REFRESH_TOKEN = '1/jQiPa_DeNHSa3NaQo-NOr-F6iw3iRD-X29xwxny_OiM'
  COLUMN_NAMES = ['Sr. No', 'Server ip address', 'Environment', 'Deployed on', 'Deployed by', 'Branch name', 'Commit id']

  def update_status(row, sheet_title, work_sheet_title, is_descending = false)
    _work_sheet = fetch_or_create_work_sheet(sheet_title, work_sheet_title)

    begin
      is_descending ? update_in_descending_format(_work_sheet, row) : update_ascending(_work_sheet, row)
    rescue Exception => e
      puts 'Exception raised while updating sheet unable to get the worksheet to write:'
      puts e.backtrace
    end

  end

  def fetch_access_token_from_refresh_token(client)
    begin
      client.authorization.grant_type = 'refresh_token'
      client.authorization.refresh_token = DeploymentSheet::REFRESH_TOKEN
      client.authorization.fetch_access_token!
      client.authorization.access_token
    rescue Exception => e
      puts 'Exception raised while fetching access token from refresh token:'
      puts e.backtrace
    end
  end

  def get_google_session
    begin
      GoogleDrive.login_with_oauth(fetch_access_token_from_refresh_token(fetch_google_client))
    rescue Exception => e
      puts 'Exception raised while login with access_token:'
      puts e.backtrace
    end
  end

  def fetch_google_client
    _client = Google::APIClient.new({application_name: 'GoogleSpreadSheet'})
    auth = _client.authorization
    auth.client_id = DeploymentSheet::CLIENT_ID
    auth.client_secret = DeploymentSheet::CLIENT_SECRET
    auth.scope = [
        'https://www.googleapis.com/auth/drive',
        'https://spreadsheets.google.com/feeds/'
    ]
    auth.redirect_uri = 'https://www.example.com/oauth2callback'
    _client
  end

  def fetch_or_create_work_sheet(sheet_title, work_sheet_title, session = get_google_session)
    _sheet = session.spreadsheet_by_title(sheet_title).nil? ? session.create_spreadsheet(sheet_title) : session.spreadsheet_by_title(sheet_title)
    _work_sheet = _sheet.worksheet_by_title(work_sheet_title).nil? ? create_work_sheet(_sheet, work_sheet_title) : _sheet.worksheet_by_title(work_sheet_title)
  end

  def create_work_sheet(sheet, title)
    populate_headers((is_first_default_work_sheet?(sheet) ? sheet.worksheets.first : sheet.add_worksheet(title)), title)
  end

  def is_first_default_work_sheet?(sheet)
    (sheet.worksheets.count == 1 and sheet.worksheets.first.title == 'Sheet1')
  end


  def populate_headers(work_sheet, title)
    work_sheet.title = title
    DeploymentSheet::COLUMN_NAMES.each_with_index do |value, index|
      work_sheet[1, index+1] = value
    end
    work_sheet.save
    work_sheet
  end

  def move_rows_forward(worksheet)
    (1..worksheet.num_rows).to_a.reverse.each do |index|
      (1..worksheet.num_cols).each do |col|
        worksheet[index+1, col] = worksheet[index, col]
      end
    end
  end

  def update_ascending(worksheet, row)
    _row = []
    row.split(' ').each { |v| _row << v.gsub('@', ' ') }
    _row.insert(0, worksheet.num_rows+1)
    row_index = worksheet.num_rows + 1
    (1.. worksheet.num_cols).each do |i|
      worksheet[row_index, i] = _row[i-1]
    end
    puts "#{worksheet.rows.last.inspect }"
    worksheet.save
  end

  def update_in_descending_format(worksheet, row)
    _row = []
    row.split(' ').each { |v| _row << v.gsub('@', ' ') }
    _row.insert(0, worksheet.num_rows+1)
    move_rows_forward(worksheet)
    (1.. worksheet.num_cols).each do |i|
      worksheet[2, i] = _row[i-1]
    end
    puts "#{worksheet.rows[1].inspect }"
    worksheet.save
  end
end
