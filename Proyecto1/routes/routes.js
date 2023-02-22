const express = require('express');

var cors = require('cors')

var app = express.Router()

var CONTROLLERS = require('../controllers/controllers')
var app = express.Router()
app.use(cors())



var baseurl = '/api/'


//CONSULTAS
app.get(baseurl + 'consulta1',              CONTROLLERS.cons1)
app.get(baseurl + 'consulta2',              CONTROLLERS.cons2)
app.get(baseurl + 'consulta3',              CONTROLLERS.cons3)
app.get(baseurl + 'consulta4',              CONTROLLERS.cons4)
app.get(baseurl + 'consulta5',              CONTROLLERS.cons5)
app.get(baseurl + 'consulta6',              CONTROLLERS.cons6)
app.get(baseurl + 'consulta7',              CONTROLLERS.cons7)
app.get(baseurl + 'consulta8',              CONTROLLERS.cons8)
app.get(baseurl + 'consulta9',              CONTROLLERS.cons9)
app.get(baseurl + 'consulta10',             CONTROLLERS.cons10)
//ELIMINAR DATOS
app.get(baseurl + 'eliminarTemporal',       CONTROLLERS.deleteTemp)
app.get(baseurl + 'eliminarModelo',         CONTROLLERS.deleteMod)
//CARGA MASIVA
app.get(baseurl + 'cargarTemporal',         CONTROLLERS.chargeTemp)
//CREAR TABLAS
app.get(baseurl + 'cargarModelo',           CONTROLLERS.chargeModel)


module.exports = app;