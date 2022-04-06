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
