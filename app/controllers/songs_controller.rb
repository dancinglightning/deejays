class SongsController < ApplicationController

  before_action :check_user, only: [:show, :edit, :update , :destroy]

  before_action :check_given , :only => [:index ]

  before_action :authenticate_user! , :only => [:index , :edit , :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @q = Song.ransack( params[:q] )
    @q.sorts = 'date_added desc' if @q.sorts.empty?
    @song_scope = @q.result(:distinct => true).includes(:user).includes(:main_genre)
    @songs = @song_scope.paginate( :page => params[:page], :per_page => 20 )
    tag_used
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)
    @song.date_added = Date.today

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
        tag_given
        SongMailer.notify(@song).deliver_later
      else
        logger.error @song.errors.inspect
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to songs_path, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        logger.error @song.errors.inspect
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    unless current_user.admin
      return redirect_back fallback: root_url , :alert => "Access denied."
    end
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def tag_used
      user = current_user
      user.used = Date.today
      user.count += 1
      user.save!
    end

    def tag_given
      user = current_user
      user.given = Date.today
      user.count = 0
      user.save!
    end

    def check_given
      current = current_user
      return unless current
      return if current.admin?
      given = current.given
      if !given or ((Date.today - 3.month) > given )  # && ( current.count > 5 )
        return redirect_to :new_song, :alert => "Read below on the rules of this service."
      end
    end

    def check_user
      @song = Song.where(:id => params[:id]).first
      current = current_user
      return unless current
      unless current.id == @song.user_id or current.admin
        return redirect_to root_path , :alert => "Access denied."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit( :title, :artist, :album, :tempo, :main_genre_id,:sub_genre,
                                    :link, :info , :user_id, :"date_added(1i)",
                                    :"date_added(2i)", :"date_added(3i)")
    end
end
