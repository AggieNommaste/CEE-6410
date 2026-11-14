# Import pandas and plotly
# If libraries are not installed run "pip install pandas plotly" in terminal

import pandas as pd
import plotly.express as px

# Create the panda's dataframe from csv file
df = pd.read_csv('./NSGA2-MatlabReservoir/HW8_altsNew.csv', header=0)

# Create a parallel coordinates plot using plotly
fig = px.parallel_coordinates(
    df,
    color='Dominance',  # Must be a numeric column for continuous color scales
    dimensions=[
        'FloodIntensity',
        'UnmetIrrDemand',
        'UnmetHydroDemand',
        'UnmetRecreationDemand',
        'x1',
        'x2',
        'x3',
    ],
    # Set the title and color scale for plot
    color_continuous_scale=px.colors.sequential.Blues_r,
    title='CEE 6410 Parallel Coordinates Plot',
)

# Show the interactive plot
fig.show()


# Make matrix scatter plot using plotly
fig = px.scatter_matrix(
    df,
    color='Dominance',
    dimensions=[
        'FloodIntensity',
        'UnmetIrrDemand',
        'UnmetHydroDemand',
        'UnmetRecreationDemand',
        'x1',
        'x2',
        'x3',
    ],
    # Set title and color scale for plot
    color_continuous_scale=px.colors.sequential.Blues_r,
    title='CEE 6410 Scatter Matrix Plot',
    )
# update the figure so the labels look better
fig.update_layout(height=1500)
# Show the interactive plot
fig.show()

