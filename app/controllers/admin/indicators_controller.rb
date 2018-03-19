module Admin
  # IndicatorsController
  class IndicatorsController < AdminController
    before_action :set_indicator, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /indicators
    def index
      @q = Indicator.ransack(params[:q])
      indicators = @q.result(distinct: true)
      @objects = indicators.page(@current_page)
      @total = indicators.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to indicators_path(page: @current_page.to_i.pred, search: @query)
      end
      @indicators = Indicator.all
      respond_to do |format|
        format.html
        format.xls { send_data(@indicators.to_xls) }
      end
    end

    # GET /indicators/1
    def show
    end

    # GET /indicators/new
    def new
      @indicator = Indicator.new
    end

    # GET /indicators/1/edit
    def edit
    end

    # POST /indicators
    def create
      @indicator = Indicator.new(indicator_params)

      if @indicator.save
        redirect(@indicator, params)
      else
        render :new
      end
    end

    # PATCH/PUT /indicators/1
    def update
      if @indicator.update(indicator_params)
        redirect(@indicator, params)
      else
        render :edit
      end
    end

    def clone
      @indicator = Indicator.clone_record params[:indicator_id]

      if @indicator.save
        redirect_to admin_indicators_path
      else
        render :new
      end
    end

    # DELETE /indicators/1
    def destroy
      @indicator.destroy
      redirect_to admin_indicators_path, notice: actions_messages(@indicator)
    end

    def destroy_multiple
      Indicator.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_indicators_path(page: @current_page, search: @query),
        notice: actions_messages(Indicator.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_indicator
      @indicator = Indicator.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def indicator_params
      params.require(:indicator).permit(:name, :value)
    end

    def show_history
      get_history(Indicator)
    end
  end
end
