Here is a basic starter code for a web application using Node.js, Express.js, and MongoDB. This code includes basic functionality such as user registration, login, and product listing.

```javascript
// Import required modules
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const passport = require('passport');

// Import routes
const users = require('./routes/api/users');
const products = require('./routes/api/products');

// Initialize app
const app = express();

// Bodyparser middleware
app.use(
  bodyParser.urlencoded({
    extended: false
  })
);
app.use(bodyParser.json());

// DB Config
const db = require('./config/keys').mongoURI;

// Connect to MongoDB
mongoose
  .connect(
    db,
    { useNewUrlParser: true }
  )
  .then(() => console.log('MongoDB successfully connected'))
  .catch(err => console.log(err));

// Passport middleware
app.use(passport.initialize());

// Passport config
require('./config/passport')(passport);

// Routes
app.use('/api/users', users);
app.use('/api/products', products);

const port = process.env.PORT || 5000;

app.listen(port, () => console.log(`Server up and running on port ${port} !`));
```

This is a very basic setup and does not include the actual implementation of the routes and the passport configuration. You would need to create these files and directories and implement the logic according to your needs.

To deploy this to GitHub, you would need to initialize a Git repository in your project directory, commit your changes, and then push to a new repository on GitHub:

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/your-repo-name.git
git push -u origin master
```

Please replace "yourusername" and "your-repo-name" with your actual GitHub username and the name of your repository.

Remember, this is just a basic setup. An e-commerce application would require a lot more functionality, including but not limited to product categories, shopping cart, order processing, payment gateway integration, etc.