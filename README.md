# OSCaR

### Open Source Case-management and Record-keeping.

### Requirements

* Docker Desktop (latest stable version for your platform)

### Getting Started

Given that we are using Docker, then most common development tasks you will just need the _core services_ which are essentially the OSCaR App Service (Rails) and the OSCaR Database Service (Postgres). To spin these services up only, use the following `make` command:

```
make start_core
```

...and in a new terminal window run:

```
make webpack_dev_server
```

See the project [Makefile](./Makefile) for a list of all the available commands.

Once the containers have fired up open a web browser and navigate to [http://localhost:3000](http://localhost:3000) to open the app. To login, click on the 'dev' organizations logo (there should only be the one logo) and the username (email) is any of the users (listed in the 'users' sheet) of the [lib/devdata/dev_tenant.xlsx](lib/devdata/dev_tenant.xlsx) spreadsheet with the password set to `123456789`.

*NOTE* If this is the first time you have run this you may need to stop the containers and run it again!

## Troubleshooting

#### Issue pending migrations when starting Docker container

If you have pending migrations that **prevent the Docker container from starting** for example:

```
app              | You have 2 pending migrations:
app              |   20200603071312 ________
app              |   20200603081325 ________
app              | Run `rake db:migrate` to update your database then try again.
app exited with code 1
```

Then you can fix this by running the following command and then starting services again.

```
make db_migrate
```

#### Issue pending migrations with running the application

If after you start the application and you see the following in the terminal:

```
Migrations are pending. To resolve this issue, run: bin/rake db:migrate RAILS_ENV=development
```

Then you need to run the migration in a terminal session in the running docker container. Keep the services running and then run the following command:

```
make db_migrate
```

#### Issue during db migration

If you get a an error while running database migrations for example:

```
StandardError: An error has occurred, this and all later migrations canceled:
```

Then you can drop the database and restart the services like so:

```
make stop_all
make db_drop
make start_core
```

Note after doing this you may still need to run the database migrations. If you still have an error with the migration then check the migrations and ask the developer who committed them to help you!

#### Issue missing Gem dependency

Sometimes you might start the service and the container cannot start because it returns an error due to a missing Gem dependency, something like this:

```
app |  Could not find ________ in any of the sources
app |  Run `bundle install` to install missing gems.
app |  exited with code 7
```

Then, it means there is a Gem depenency missing. You should rebuild the image like this and then start the services again.

```
make build_app
```

#### Issue version discrepency with a Gem

Sometimes you might start the service and the container cannot start because it returns an error due to a version discrepency with a Gem, something like this:

```
app | The bundle currently has ______ locked at x.y.z.
app | Try running `bundle update ______`
app |
app | If you are updating multiple gems in your Gemfile at once,
app | try passing them all to `bundle update`
app | Run `bundle install` to install missing gems.
app | exited with code 7
```

Then, it means there is a Gem version discrepency. You should rebuild the image like this and then start the services again.

```
make build_app
```

#### Issue missing JavaScript dependency

Then, it means there is a JavaScript package depenency missing. You should rebuild the image like this and then start the services again.

In your terminal you might see something like this or someother error representing a missing JavaScript module.

Usually what's happened is the yarn.lock file contains a reference to a module that is not currently in your `node_modules` folder:

```
Module not found: _____
Error: Can't resolve _____
```

To fix this issue, run the following commands:

```
make yarn_install
```

### Gazetteer Data Import (OPTIONAL)

Since importing the Gazetteer data takes sometime and the spreadsheet files are fairly large this as been left as an option if you need it.

Firstly, download the [Cambodia Gazetteer Spreadsheets](https://drive.google.com/drive/folders/1ff0GbLahKc0roUB71yjFNDwLY328AeKE), extract the zip file into the following local project directory `vendor/data/villages/xlsx`.

Now, inside the app container, run the following rake task where 'dev' is the name of the tenant / schema you want to import the Gazetteer Data into.

```
rake communes_and_villages:import['dev']
```

### Docker Commands

Start bash session in the 'app' service container. Once you have a session, you can use it like you would normally use your local terminal, running `rake` tasks, starting the `rails c` console etc, etc

To start a bash terminal that is running inside the Docker container run:

```
make bash_console
```

```
make rails_console
```

There is also a make command to drop the database

```
make db_drop
```

Check the local [Makefile](./Makefile) for a complete list of available commands.

### pgAdmin

The Docker Compose file contains a pgAdmin service. After `docker-compose up` spins up all the services, its possible to connect to pgAdmin at [http://localhost:5050/](http://localhost:5050/). The pgAdmin username and password are in the `pgadmin` services definition in [docker-compose.yml](./docker-compose.yml). To connect to the oscar database, simply expand the OSCaR Server Group in the top left and click on the database. You will be asked to enter the db password (123456789).

Note, if you only started the 'core' services and you want to fire up pgAdmin service too, then simply run the following command at your local terminal  (note this will also startup the `db` service (Postgres) if it is not running):

```
docker-compose up pgadmin
```

### Mongo Express

The Docker Compose file contains a [Mongo Express](https://github.com/mongo-express/mongo-express) service. After `docker-compose up` spins up all the services, its possible to connect to Mongo Express at [http://localhost:8081/](http://localhost:8081/). There is no username or password required.

Note, if you only started the 'core' services and you want to fire up Mongo Express service too, then simply run the following command at your local terminal (note this will also startup the `mongo` service (MongoDB) if it is not running):

```
docker-compose up mongo-express
```

### Issue Reporting

If you experience with bugs or need further improvement, please create a new issue under [Issues](https://github.com/rotati/oscar-web/issues).

### Contributing to OSCaR

Pull requests are very welcome. Before submitting a pull request, please make sure that your changes are well tested. Pull requests without tests will not be accepted.

### Authors

OSCaR is developed in partnership by [Rotati Consulting (Cambodia)](http://www.rotati.tech) and [CIF](http://www.childreninfamilies.org)

### License

OSCaR Web Application is released under [AGPL](http://www.gnu.org/licenses/agpl-3.0-standalone.html)
