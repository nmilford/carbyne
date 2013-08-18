defmodule Carbyne do
  @moduledoc """
  Listens for TCP traffic on @carbyne_port

  Expects a graphite metric tuple, but does not validate it.

  Writes it to a file using the metric path as the directory path.
  """

  @carbyne_port 2003
  @carbyne_path "/var/tmp/carbyne/"

  @doc """
  Starts up the server.
  """
  def run do
    IO.puts "Carbyne starting up!"
    server = listen(@carbyne_port)
    get_metric(server)
  end

  @doc """
  Sets up the server to listen on a TCP port.
  """
  def listen(port) do
    { :ok, server } = Socket.listen "tcp://0.0.0.0:#{port}"
    IO.puts "Listening for TCP connections on port #{port}"
    server
  end

  @doc """
  Takes a list with 3 values (path, value, time) and writes them to a simple
  text file named after the time value in the tuple.  The file is placed in a
  directory named after the metric path.

  Eventually these will be whisper files or write to KairosDB or something. 
  """
  def write_metric(metric) do
    [ path, value, time ] = String.split(metric)
    file = "#{@carbyne_path}#{String.replace(path, ".", "/")}/#{time}"
    File.mkdir_p!("#{@carbyne_path}#{String.replace(path, ".", "/")}")
    File.touch!(file)
    File.write!(file, value)
  end

  @doc """
  Grabs the input from an open TCP port, closes the client connection and calls
  write_metric(), then calls itself again, forever, until the server is killed.

  Eventually I'll validate the input :P
  """
  def get_metric(server) do
    client = server.accept!
    metric = client.recv!
    client.close
    write_metric(metric)
    get_metric(server)
  end

end