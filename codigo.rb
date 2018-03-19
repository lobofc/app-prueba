module Admin
  # ChartsController
  class ChartsController < AdminController
    before_action :set_chart, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    require 'csv'
    require 'json'

    # GET /charts
    def index

      @data = []
      @prueba = Banner.last
      @banner = Banner.last.banner
      @indicador = Indicator.last
      CSV.foreach(@banner.path, headers: true) do |row|
        @data << JSON.pretty_generate(row.to_hash)
      end

      options = { col_sep: '|', converters: :numeric, headers: true }

      CSV.foreach(@banner.path, options) do |row|
        filename = "#{row['date,market1'].downcase}.json"
        @data << JSON.pretty_generate(row.to_hash)
      end


      @result = CSV.open("#{@banner.path}", :headers => true).map { |x| x.to_hash }.to_json
    end

    def un_chart
      @chart1 = Banner.find(1)
      @chart2 = Banner.find(2)
      data1 = File.open("#{@chart1.banner.path}").read
      data2 = File.open("#{@chart2.banner.path}").read
      @result1 = CSV.parse(data1)
      @result2 = CSV.parse(data2)
      render json: [{name: 'Count', data: @result1},{name: 'Count', data: @result2}]
    end
