const express = require('express')

const adminRoute = require('./routes/admin')
const featureRoute = require('./routes/feature')
const roomRoute = require('./routes/room')

const mongoose = require('mongoose')

const app = express()

let devurl = 'mongodb://localhost/efoy'

mongoose.connect(devurl, {useCreateIndex : true,useNewUrlParser : true, useUnifiedTopology : true})

let db = mongoose.connection

db.once('open', () => {
    console.log('Database Connected')
})
db.on('error', err => {
    if (err) throw err;
    console.log(err)  
})



app.use(express.urlencoded({extended : false}))
app.use(express.json())

app.use('/admins', adminRoute)
app.use('/features', featureRoute)
app.use('/rooms', roomRoute)

app.use((req, res) => {
    res.status(404).json({
        error : true,
        message : 'Page Not Found!'
    })
})

const PORT = process.env.PORT || 5000

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
})