class HistoryRecordsController < ApplicationController
  before_action :set_history_record, only: [:show, :edit, :update, :destroy]

  # GET /history_records
  # GET /history_records.json
  def index
    @history_records = HistoryRecord.uid_order
  end

  # GET /history_records/1
  # GET /history_records/1.json
  def show
  end

  # GET /history_records/new
  def new
    @history_record = HistoryRecord.new
  end

  # GET /history_records/1/edit
  def edit
  end

  # POST /history_records
  # POST /history_records.json
  def create
    @history_record = HistoryRecord.new(history_record_params)

    respond_to do |format|
      if @history_record.save
        format.html { redirect_to @history_record, notice: 'History record was successfully created.' }
        format.json { render :show, status: :created, location: @history_record }
      else
        format.html { render :new }
        format.json { render json: @history_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /history_records/1
  # PATCH/PUT /history_records/1.json
  def update
    respond_to do |format|
      if @history_record.update(history_record_params)
        format.html { redirect_to @history_record, notice: 'History record was successfully updated.' }
        format.json { render :show, status: :ok, location: @history_record }
      else
        format.html { render :edit }
        format.json { render json: @history_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /history_records/1
  # DELETE /history_records/1.json
  def destroy
    @history_record.destroy
    respond_to do |format|
      format.html { redirect_to history_records_url, notice: 'History record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_history_record
    @history_record = HistoryRecord.find_by(uid: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def history_record_params
    params.require(:history_record).permit(:uid, :data)
  end
end
