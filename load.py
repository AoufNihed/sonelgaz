import pandas as pd 
from sqlalchemy import create_engine
conn_string = 'postgresql://postgres:aoufnihed@localhost/sonelgaz'


db=create_engine(conn_string)
conn=db.connect()

df=pd.read_csv(r"C:\Users\hey\OneDrive\Bureau\sonelgaz\Algeriadata.csv")
df.to_sql('Algeriadata',con=conn,if_exists='replace',index=False)

