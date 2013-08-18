defmodule Carbyne do

  @carbyne_port 2003

  defrecord Metric, path: nil, metric: 0, time: 0

  def run do
    IO.puts "Carbyne starting up!"
    server = listen(@carbyne_port)
    get_metric(server)
  end

  def listen(port) do
    { :ok, server } = Socket.listen "tcp://0.0.0.0:#{port}"
    IO.puts "Listening for TCP connections on port #{port}"
    server
  end

  def get_metric(server) do
    client = server.accept!
    metric = client.recv!
    client.close
    IO.puts String.split(metric)
    [ path, value, time ] = String.split(metric)
    IO.puts """
    Path:   #{path}
    Metric: #{value}
    Time:   #{time}
    """
    get_metric(server)
  end

end


# To test
# in the project dir type 
#
# iex -S mix
#
# In the iex shell call Carbyne.run
#
# iex(1)> Carbyne.run
#
# In another shell fire of Graphite style metrics.
# while :; do  echo "servers.loadavg5 $RANDOM $(date +%s)" | nc 127.0.0.1 2003; sleep 3 ; done