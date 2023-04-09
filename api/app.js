//connect to MongoDB;
const db = require('./config/db')
var express = require("express")
var express_handleBar = require("express-handlebars")
var app = express();
const cors = require("cors")
const Product = require('./models/product');
const Category = require('./models/category');
app.use(cors())
//Cổng PORT chung khi kết nối
var PORT = 3000;

//Khai báo ban đầu
app.engine(".hbs", express_handleBar.engine({ extname: ".hbs", defaultLayout: "main" }));
app.set('view engine', '.hbs');
app.use(express.static("public"))
app.use(express.static("upload"))

//thêm 2 dòng dưới để lấy được chuỗi json và lấy được data từ form input
app.use(express.json());
app.use(express.urlencoded({
    extended: false,
}));


//Lấy dữ liệu ban đầu về trang HOME .
app.get("/home", async function (req, res) {
    await Product.find().then(data => {
        const products = {
            itemProduct: data.map((item) => {
                return {
                    _id: item.id,
                    name: item.name,
                    category: item.category,
                    price: item.price,
                    image: item.image,
                    description: item.description,
                }
            })
        }
        // console.log(products.itemProduct)
        Category.find().then(data => {
            const categorys = {
                itemCategory: data.map((item) => {
                    return {
                        _id: item.id,
                        name_category: item.name_category,
                    }
                })
            }

            res.render('home', {
                itemProduct: products.itemProduct,
                itemCategory: categorys.itemCategory
            })
        })
    })
})


// ------------SignIn - SignUp ---------------
const RouterSignIn = require('./routers/signin_router');
app.use(RouterSignIn);

// ------------Product ---------------
const RouterProduct = require('./routers/product_router');
app.use(RouterProduct);
// ------------Search Product-----------------
const SearchRouter = require('./routers/search_router');
app.use(SearchRouter);
// ------------Category ---------------
const RouterCategory = require('./routers/category_router');
app.use(RouterCategory);
// ------------Set Role --------------
const RouterRole = require('./routers/set_role_router')
app.use(RouterRole);
const RouterStatis = require('./routers/statis_router')
app.use(RouterStatis);

// -----------rest ful product---------------
const productRestController = require("./restFull-api/product.api")
app.use("/api/product", productRestController);
// -----------Login - Register---------------
const signIn_signUp = require("./restFull-api/user.api");
app.use('/api', signIn_signUp);

//------------Category-----------------
const categoryRestApi = require("./restFull-api/category.api");
app.use('/api/category', categoryRestApi);

app.listen(PORT)



