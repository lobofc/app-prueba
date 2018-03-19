module ChartsHelper
  def convert_to_amcharts_json(data_array)
    graph = Chart.find(data_array)
    @data = []
    options = { col_sep: '|', converters: :numeric, headers: true }
    CSV.foreach(graph.file.path, options) do |row|
      filename = "#{row['date,market1,market2'].downcase}.json"
      @data << JSON.pretty_generate(row.to_hash)
    end
    byebug
    @data.to_json.gsub(/\"text\"/, "text").html_safe
  end


  def prueba(id)
    @graph = Chart.find(id)
    data = File.open("#{@graph.file.path}").read
    @result = CSV.parse(data)
    @datos = @result.shift
    @result = @result.to_json.gsub(/\"text\"/, "text").html_safe
    respond_to do |format|
      format.html
      format.json { render :json => @users }
    end
  end

  def un_chart(chart)
    graph = Chart.find(chart)
    line_chart un_chart_path, width: "930px", height: "500px",  colors: ["#f45b5b", "#90ee7e"], library: {
        # chart: {
        #     type: 'spline'
        # },
        title: {
            text: "#{graph.name}"
        },
        # subtitle: {
        #     text: 'Irregular time data in Highcharts JS'
        # },
        navigator: {
            enabled: true,
            backgroundColor: "#90ee7e"
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: {
                month: '%e. %b',
                year: '%b'
            },
            title: {
                text: 'Fechas'
            }
        },
        yAxis: {
            title: {
                text: 'Bolsa'
            }
        }
        # tooltip: {
        #     headerFormat: '<b>{series.name}</b><br>',
        #     pointFormat: '{point.x:%e. %b}: {point.y:.2f} m'
        # },
        #
        # plotOptions: {
        #     line: {
        #         marker: {
        #             enabled: true
        #         }
        #     }
        # },

        # series: [{
        #     name: 'Winter 2007-2008',
        #
        #     data: un_chart_path
        # }]
    }
  end
  def chart_front(chart)
    graph = Chart.find(chart)
    line_chart chart_front_path(chart), width: "600px", height: "500px",  colors: ["#f45b5b", "#90ee7e"], library: {
        # chart: {
        #     type: 'spline'
        # },
        title: {
            text: "#{graph.name}"
        },
        # subtitle: {
        #     text: 'Irregular time data in Highcharts JS'
        # },
        navigator: {
            enabled: true,
            backgroundColor: "#90ee7e"
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: {
                month: '%e. %b',
                year: '%b'
            },
            title: {
                text: 'Fechas'
            }
        },
        yAxis: {
            title: {
                text: 'Bolsa'
            }
        }
        # tooltip: {
        #     headerFormat: '<b>{series.name}</b><br>',
        #     pointFormat: '{point.x:%e. %b}: {point.y:.2f} m'
        # },
        #
        # plotOptions: {
        #     line: {
        #         marker: {
        #             enabled: true
        #         }
        #     }
        # },

        # series: [{
        #     name: 'Winter 2007-2008',
        #
        #     data: un_chart_path
        # }]
    }
  end
end
