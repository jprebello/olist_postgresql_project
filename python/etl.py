import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql+psycopg2://olist_user:1234@localhost:5432/olist_db")

customers = pd.read_csv("../data/olist_customers_dataset.csv")
orders = pd.read_csv("../data/olist_orders_dataset.csv")
order_payments = pd.read_csv("../data/olist_order_payments_dataset.csv")
order_reviews = pd.read_csv("../data/olist_order_reviews_dataset.csv")
order_items = pd.read_csv("../data/olist_order_items_dataset.csv")
products = pd.read_csv("../data/olist_products_dataset.csv")
sellers = pd.read_csv("../data/olist_sellers_dataset.csv")

def clean_blank_spaces(df, columns):
    for col in columns:
        df[col] = df[col].str.strip()
    
    return df

def str_to_date(df, columns):
    for col in columns:
        df[col] = pd.to_datetime(df[col]).dt.date

    return df

customers = customers.drop(columns=["customer_zip_code_prefix"])
customers = clean_blank_spaces(customers, ["customer_id", "customer_unique_id", "customer_city", "customer_state"])

orders = orders.drop(columns=["order_delivered_carrier_date"])
orders = str_to_date(orders, ["order_purchase_timestamp", "order_approved_at", "order_delivered_customer_date", "order_estimated_delivery_date"])
orders = clean_blank_spaces(orders, ["order_id", "customer_id", "order_status"])

order_payments = clean_blank_spaces(order_payments, ["order_id", "payment_type"])

order_reviews = order_reviews.drop(columns=["review_comment_title", "review_comment_message", "review_answer_timestamp"])
order_reviews = str_to_date(order_reviews, ["review_creation_date"])
order_reviews = clean_blank_spaces(order_reviews, ["review_id", "order_id"])

order_items = order_items.drop(columns=["shipping_limit_date"])
order_items = clean_blank_spaces(order_items, ["order_id", "product_id", "seller_id"])

products = products[["product_id", "product_category_name"]]
products = clean_blank_spaces(products, ["product_id", "product_category_name"])

sellers = sellers.drop(columns=["seller_zip_code_prefix"])
sellers = clean_blank_spaces(sellers, ["seller_id", "seller_city", "seller_state"])

customers.to_sql(
    name="customers",
    con=engine,
    if_exists="append",
    index=False
)

orders.to_sql(
    name="orders",
    con=engine,
    if_exists="append",
    index=False
)

order_payments.to_sql(
    name="order_payments",
    con=engine,
    if_exists="append",
    index=False
)

order_reviews.to_sql(
    name="order_reviews",
    con=engine,
    if_exists="append",
    index=False
)

products.to_sql(
    name="products",
    con=engine,
    if_exists="append",
    index=False
)

sellers.to_sql(
    name="sellers",
    con=engine,
    if_exists="append",
    index=False
)

order_items.to_sql(
    name="order_items",
    con=engine,
    if_exists="append",
    index=False
)
