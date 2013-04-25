Redmine Sidekiq
===============

Background jobs will use the [Sidekiq](https://github.com/mperham/sidekiq) on Redmine.
You can Monitoring easily used by [Sidekiq plugin](http://www.redmine.org/plugins/sidekiq).

## Features

* Administrator can use the Sidekiq Web UI from the top menu.
* Add to autoload_paths of the Plugin '/app/workers'.
* Add Middleware of 'sidekiq-status'.

## Installation

```
$ git clone https://github.com/ogom/redmine_sidekiq ./plugins/redmine_sidekiq
```

## Example

Example of Sidekiq worker.

```
./plugins/redmine_sidekiq/workers/sandbox_worker.rb
```

## Web UI 
Enqueue from the Web UI.

```
http://[redmine]/sidekiq/sandbox
```

## CLI

Enqueue from the command line.

```
$ script/rails runner 'SandboxWorker.perform_async'
```

## License 

* MIT
