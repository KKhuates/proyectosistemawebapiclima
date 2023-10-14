defmodule SensorHub.Application do

  alias SensorHub.Sensor

  def children(_target) do
    [
      {SGP30, []},
      {BMP280, [i2c_address: 0x77, name: BMP280]},
      {VEML6030, %{}},
      {Finch, name: WeatherTrackerClient},
      {
        Publisher,
          %{
          sensors: sensors(),
          weather_tracker_url: weather_tracker_url()
          }
        }
    ]
  end
  defp sensors do
    [Sensor.new(BMP280), Sensor.new(VEML6030), Sensor.new(SGP30)]
  end
  defp weather_tracker_url do
    Application.get_env(:sensor_hub, :weather_tracker_url)
  end

  end
