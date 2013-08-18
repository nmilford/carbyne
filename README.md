carbyne
=======

An attempt to create an Elixir/Erlang backed Graphite/Carbon drop-in replacement.  

[Carbyne](http://www.extremetech.com/extreme/163997-carbyne-a-new-form-of-carbon-thats-stronger-than-graphene) is also a form of carbon that is stronger than graphene or diamond.

This is primarily a project to teach me Elixir.

### To play:

(assuming you have Erlang and Elixir installed)

Grab the repo:

`git clone git@github.com:nmilford/carbyne.git`

Enter the project directory:

`cd carbyne`

Get the project dependancies:

`mix deps.get`

Fire up the iex shell with mix:

`iex -S mix`

In the shell fire up Carbyne:

`iex(1)> Carbyne.run`

In another shell fire off some Graphite style metrics:

`while :; do  echo "servers.loadavg5 $RANDOM $(date +%s)" | nc 127.0.0.1 2003; sleep 3 ; done`

You'll see plain text files created in `/var/tmp/carbyne/servers/loadavg5/` named for the timestamp containing the metric value. Eventually they'll be whisper files or be dropped into [KairosDB](https://code.google.com/p/kairosdb/).