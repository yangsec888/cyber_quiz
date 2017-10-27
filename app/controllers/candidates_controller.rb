#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Developed by Yang Li, Kainan Zhang. Creative Common License
#
#++

class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /candidates
  def index
    @candidates = Candidate.all
    json_response(@candidates)
  end

  # POST /candidates
  def create
    if set_candidate.nil?
      @candidate = Candidate.create!(candidate_params)
    else
      @candidate.update(status: true)
    end
    json_response(@candidate, :created)
  end

  # GET /candidates/:email
  def show
    json_response(@candidate)
  end

  # PUT /candidates/:email
  def update
    @candidate.update(status: false) unless set_candidate.nil?
    head :no_content
  end

  # DELETE /candidates/:email
  def destroy
    @candidate.destroy
    head :no_content
  end

  def synchronize
    # replace current database with candidate_list.yml
    @candidate_list = YAML.load_file(Rails.root.join('config', 'candidate_list.yml'))
    Candidate.destroy_all
    ActiveRecord::Base.connection.execute('TRUNCATE candidates')
    @candidate_list.each do |name, email|
      Candidate.create(name: name, email: email, status: true)
    end
    redirect_to reporter_list_path, notice: 'The list file has been synchronized.'
  rescue
    redirect_to reporter_list_path, alert: 'Synchronization failed, please check candidate file.'
  end

  def refresh
    list = params['list']
    Candidate.all.each do |candidate|
      temp = list.length
      list.delete_if { |user| user['email'] == candidate.email }
      list.length == temp ? candidate.update(status: false) : candidate.update(status: true)
    end
    list.each do |user|
      Candidate.create!(name: user['en_name'], email: user['email'], status: true ) unless user['email'].nil?
    end
    head :ok
  end

  private

  def candidate_params
    # whitelist params
    params.permit(:name, :email, :status)
  end

  def set_candidate
    email = params[:email]
    @candidate = Candidate.find_by email: email
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end

end
