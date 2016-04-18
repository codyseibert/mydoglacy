Sequelize = require 'sequelize'
module.exports = do ->
  new Sequelize 'typr', 'root', 'testing',
    host: 'localhost'
