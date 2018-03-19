module App
  # FrontsController
  class FrontController < AppController
    layout 'layouts/templates/application'
    before_action :keppler_mailer
    require 'csv'
    require 'json'

    def custodia
    end

    def estadisticas
      @pathCSV = []
      @arrayId = []
      @charts = Chart.all
      @counter = Chart.count
      @indicators = Indicator.all

      @charts.each_with_index do |chart, index|
        path = chart.file.path.split("/")
        id = chart.id

        path.each_with_index do |path, index|
          @position = index if path == "uploads"
        end

        @position.times do |x|
          path.shift
        end

        path = path.join("/")

        @pathCSV << path
        @arrayId << chart.value_one << chart.value_two
      end


    end

    def mercadosecundario
    end

    def marcolegal
    end

    def concurso
    end

    def contrataciones
    end

    def persona
    end

    def aplicacion
    end

    def calculadora
    end

    def tarifas
    end

    def colocacion
    end

    def contacto
    end

    def ventajas
    end

    def emisor
    end

    def juridica
    end

    def quienessomos
    end

    def estructuracion
    end

    def index
      @indicators = Indicator.all
      @banners = Banner.last(3)
    end

    def colocacioninstrumentos
    end

    def atencion
    end

    def cssslider
    end

    private
    def keppler_mailer
      @message = KepplerContactUs::Message.new
    end

  end
end
