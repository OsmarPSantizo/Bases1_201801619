const express = require('express');
const app = express();
const routes = require('./routes/routes')
app.use(express.json());
app.use(routes);

db = require('./models')

app.listen(4000,()=>{
    console.log('Server running! in port 4000'  )
})

