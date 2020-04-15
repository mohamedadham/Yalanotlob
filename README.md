
# Yalanotlob

Yalanotlob is web application allows the users to make order and add friends or group of friends to their orders.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them

```
1- ruby version'2.6.3'
2- rails >= 6.0.0

```

### Installing

A step by step that tell you how to get a development env running.

```
1- Clone the project
2- Create Database "yalanotlob"
3- Configure database configuration in database.yml with your username and password
4- For Google and Facebook APIs"
  a- Delete credentials.yml in config
  b- Run EDITOR="code --wait" rails credentials:edit
  c- write the Google and Facebook APIs' keys 
    google_api_public: 
    google_api_secret:
    facebook_api_public:
    facebook_api_secret:
  d- Save then close the file 
5- $ rails db:migrate
6- run bundle install
5- run rails s
```


## Built With

* [Rails](https://guides.rubyonrails.org/) - The web framework used

## Authors

  1. [Dalia Matter](https://github.com/DaliaMatter)
  2. [Kareem Saeed](https://github.com/KareemMorsy30)
  3. [Nouran Yehia](https://github.com/Nouran-yehia)
  4. [Mohamed Adham](https://github.com/mohamedadham)
  5. [Mohamed Mostafa](https://github.com/MohamadFeeshar)





