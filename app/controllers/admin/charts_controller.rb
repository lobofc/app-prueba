module Admin
  # ChartsController
  class ChartsController < AdminController
    before_action :set_chart, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    require 'csv'
    require 'json'

    # GET /charts
    def index
      @q = Chart.ransack(params[:q])
      charts = @q.result(distinct: true)
      @objects = charts.page(@current_page)
      @total = charts.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to charts_path(page: @current_page.to_i.pred, search: @query)
      end
      @charts = Chart.all
      respond_to do |format|
        format.html
        format.xls { send_data(@charts.to_xls) }
      end
    end

    # GET /charts/1
    def show
    end

    # GET /charts/new
    def new
      @chart = Chart.new
    end

    # GET /charts/1/edit
    def edit
    end

    # POST /charts
    def create
      @chart = Chart.new(chart_params)

      if @chart.save
        redirect(@chart, params)
      else
        render :new
      end
    end

    # PATCH/PUT /charts/1
    def update
      if @chart.update(chart_params)
        redirect(@chart, params)
      else
        render :edit
      end
    end

    def clone
      @chart = Chart.clone_record params[:chart_id]

      if @chart.save
        redirect_to admin_charts_path
      else
        render :new
      end
    end

    # DELETE /charts/1
    def destroy
      @chart.destroy
      redirect_to admin_charts_path, notice: actions_messages(@chart)
    end

    def destroy_multiple
      Chart.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_charts_path(page: @current_page, search: @query),
        notice: actions_messages(Chart.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_chart
      @chart = Chart.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chart_params
      params.require(:chart).permit(:name, :file, :value_one, :value_two)
    end

    def show_history
      get_history(Chart)
    end
  end
end
