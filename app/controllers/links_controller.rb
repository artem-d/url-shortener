class LinksController < ApplicationController
  before_action :set_link, only: [:destroy]

  skip_before_filter :require_login, only: [:go, :new, :create]

  def go
    @link = Link.find_by(out_url: params[:out_url])
    if redirect_to @link.in_url, status: 301
      @link.clicks += 1
      @link.save
    end
  end

  # GET /links/new
  def new
    @link = Link.new
    @links = Link.recent
    if logged_in?
      @user_links = Link.recent_for_user(current_user)
      @links_excluding_user_links = Link.recent.excluding_links_of_user(current_user)
    end
  end

  # POST /links
  # POST /links.json
  def create
    @links = Link.recent
    @link = Link.new(link_params)

    if logged_in?
      @link.user_id = current_user.id
      @user_links = Link.recent_for_user(current_user)
    end

    respond_to do |format|
      if @link.save
        format.html { redirect_to new_link_path, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to new_link_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:in_url, :out_url, :clicks)
    end
end
