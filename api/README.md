# The Sinatra backend

## Project setup
```
cd api
bundle install
```

### Testing
You can run the backend tests found in  `spec` folder with:
```
rspec spec
```

#### Launch server
```
ruby app.rb
```

## Deployed backend
You can make a POST request to `https://indexator-sinatra.herokuapp.com/v1/indexations` with a body that has the following keys:
`base_rent`: integer | must be present, non zero and positive

`region`: string | must be present and one of: brussels, flanders, wallonia

`start_date`: string | must be present, formated as "YYYY-MM-dd", and in the past

`signed_on`: string | must be present, formated as "YYYY-MM-dd", and in the past

Naturally, `start_date` should correspond to a date that is chronologically after `signed_on`.

Here is an example body:
```
{
  "base_rent": 500,
  "region": "brussels",
  "start_date": "2010-09-01",
  "signed_on": "2010-07-25"
}
```
