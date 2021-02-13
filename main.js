const express = require("express"),
  router = require("./routes/routes"),
  { port } = require("./utils/config"),
  { mongooseConnection } = require("./utils/mongo_util"),
  
  bodyParser = require("body-parser"),
  app = express();
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.use(bodyParser.json());
mongooseConnection();
app.use(express.static(__dirname));
// app.use(express.multipart());
// app.use(express.methodOverride());

app.use("/api", router);
app.listen(port, () => {
  console.log(`server running on port ${port}`);
});
