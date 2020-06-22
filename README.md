# Tembeza

Elixir application that fetches data from an url.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

* [GiHub](https://github.com/AdolfodelSel/Derivco) - Proyect code

### Running

A step by step series of examples that tell you how to get a development env running

Download the code

```
git clone https://github.com/AdolfodelSel/Tembeza.git
```

Go to Tembeza folder and install the dependencies. The third command it is not useful at all for this app ut if you don't run ti you will get some warnings.

```
cd Tembeza
mix deps.get
cd assets && npm install
```

Run it in the interactive mode:

```
iex -S mix phx.server
```

## Running the tests

You have to have mix installed.

```
$ cd Tembeza
$ sudo mix test
```

## API

Here you have an example of a cURL request, you only need to change the variable called "url" for the value that you want to fetch.

```
curl -X GET \
  'http://localhost:4000/api/fetch?url=url' \
  -H 'Postman-Token: 6f1bfa32-e3d1-493d-b010-97bf820c17c5' \
  -H 'cache-control: no-cache'
```

## Built With

* [Phoenix](https://phoenixframework.org/) - The framework used
* [GiHub](https://github.com/) - Used to store the poryect code

## Author

* **Adolfo del Sel Llano**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details