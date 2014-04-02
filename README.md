Redmine Sidekiq
===============

Background jobs will use the [Sidekiq](https://github.com/mperham/sidekiq) on Redmine.
You can Monitoring easily used by [Sidekiq plugin](http://www.redmine.org/plugins/sidekiq).

## Features

* Administrator can use the Sidekiq Web UI from the top menu.
* Add to autoload_paths of the Plugin `/app/workers`.

## Installation

```
$ git clone https://github.com/ogom/redmine_sidekiq ./plugins/redmine_sidekiq
$ bundle install
```

## Usage

### Worker

Add worker classes in `/plugins/[your plugin]/app/workers`.

```
class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    # do something
  end
end
```

### Sidekiq Web UI

It appears in the top menu.

![top menu](https://f.cloud.github.com/assets/471923/491345/149e41a4-ba19-11e2-8374-cc3a7861e915.png)


## Example

Example of Sidekiq worker.

```
./plugins/redmine_sidekiq/workers/sandbox_worker.rb
```

### Sandbox Web UI
Enqueue from the Web UI.

```
http://[redmine]/sidekiq/sandbox
```

Enqueue, click the `perform_async(*args)` of the Jobs.

![sandbox](https://f.cloud.github.com/assets/471923/491347/24df23c6-ba19-11e2-9a31-1dadae4795c7.png)


### CLI

Enqueue from the command line.

```
$ script/rails runner 'SandboxWorker.perform_async'
```

## License

* MIT
