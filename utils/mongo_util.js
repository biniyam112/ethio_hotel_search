const mongoose = require("mongoose"),
  { db_URL } = require("./config");

module.exports = {
  
  mongooseConnection: () => {
    mongoose.Promise=global.Promise;
    mongoose.connect(db_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    
    mongoose.connection
      .on("connected", () => {
        console.log("database connected successfully");
      })
      .on("error", (err) => {
        console.log(`error on connecting database ${err}`);
      });
  },
};
