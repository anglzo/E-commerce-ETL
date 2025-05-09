from typing import Dict
import pandas as pd
from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    
    for key, df in data_frames.items():
        pd.DataFrame(df).to_sql(name = key, con = database, index= False, if_exists= 'replace')
        print(f'the table {key} has been added')




