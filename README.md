# Small application with separate, independant front (Vue) and back (Sinatra).
Small app where Belgian real-estate owners can see what is the legal indexed rent for their properties based on the region, base rent, contract sign date and rental start date.

## Project setup
For Ubuntu users, the dev script should open two terminal tabs. One installs the back end dependencies and launches the backend server, the other installs the fron end dependencies and launches the frontend server
```
npm run dev
```
WSL2 on windows is not quite there yet for this to work. macOS is a mystery, you'll let me know if it doesn't run 😀

### Testing the backend api
From within the `api` folder:
```
rspec
```

Or from root folder with:
```
npm run test
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
