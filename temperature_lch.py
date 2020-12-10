import numpy as np
import plotly.graph_objects as go
import plotly
import yaml

def yaml_loader(filepath):
    """Loads a yaml file"""
    with open(filepath, "r") as file_descriptor:
        data = yaml.safe_load(file_descriptor)
    return data

yaml_data = yaml_loader('bb_temp.yml')

x_data = ['January','February','March','April','May','June','July','August','September','October','November','December']
y_high = [1.0,4.4,9.5,15.2,20.9,23.6,25.5,25.8,20.6,14.6,6.5,1.9]
y_low = [-6.7,-5.2,-1.5,2.4,7.2,10.1,11.5,11.1,None,3.4,-0.8,-4.6]
y_avg = [-2.9,-0.8,3.5,8.7,14.0,16.9,18.5,18.0,13.5,8.2,2.7,-1.4]

fig = go.Figure()
fig.add_trace(go.Scatter(x=yaml_data['months'], y=y_low,name='Min Temp',connectgaps=True))
fig.add_trace(go.Scatter(x=x_data, y=yaml_data['max'], name='Max Temp', ))



fig.add_trace(go.Scatter(x=x_data, y=y_avg, name='Avg Temp'))

fig.update_layout(title='Maximum, Average and minimum Temperatures in Banska Bystrica',
                   xaxis_title='Month',
                   yaxis_title='Temperature (degrees C°)',
                   modebar=dict(color='cyan'))
fig.update_traces(dx=10.0,dy=10.0)
fig.show()