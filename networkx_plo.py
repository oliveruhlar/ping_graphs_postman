import plotly.graph_objects as go
import networkx as nx
import yaml

G = nx.path_graph(7)
G.remove_edges_from(G.edges())
G.add_edge(0,4)
#G.add_edge(0,5)
#G.add_edge(0,6)
G.add_edge(1,4)
G.add_edge(1,5)
G.add_edge(1,6)
#G.add_edge(2,4)
G.add_edge(2,5)
G.add_edge(2,6)
G.add_edge(3,4)
G.add_edge(3,5)
G.add_edge(3,6)

nx.write_yaml(G,"netx_data.yml")
G = nx.read_yaml("netx_data.yml")
#pos = nx.random_layout(G)
#pos = nx.spiral_layout(G)
#pos = nx.spectral_layout(G)
#pos = nx.spring_layout(G)
#pos = nx.planar_layout(G)
#pos = nx.kamada_kawai_layout(G)
#pos = nx.circular_layout(G)

"""Bipartite graph"""

top = nx.bipartite.sets(G)[0]
pos = nx.bipartite_layout(G, top)

edge_x = []
edge_y = []
for edge in G.edges():
    x0, y0 = tuple(pos[edge[0]])
    x1, y1 = tuple(pos[edge[1]])
    edge_x.append(x0)
    edge_x.append(x1)
    edge_x.append(None)
    edge_y.append(y0)
    edge_y.append(y1)
    edge_y.append(None)

edge_trace = go.Scatter(
    x=edge_x, y=edge_y,
    line=dict(width=0.5, color='#888'),
    hoverinfo='none',
    mode='lines')

node_x = []
node_y = []
for node in G.nodes():
    x, y = tuple(pos[node])
    node_x.append(x)
    node_y.append(y)

node_adj = []
node_text = []
for node, adj in enumerate(G.adjacency()):
    node_adj.append(len(adj[1]))
    node_text.append('Number of connections: '+str(len(adj[1])))

node_trace = go.Scatter(
    x=node_x, y=node_y,
    mode='markers+text',
    customdata=node_text,
    hovertemplate='%{customdata}<extra></extra>',
    text=[i for i in range(G.order())],
    marker=dict(
        showscale=True,
        colorscale='Hot',
        reversescale=False,
        color=[],
        size=20,
        colorbar=dict(
            thickness=15,
            title='Number of Connections',
            xanchor='left',
            titleside='right'
        ),
        line_width=2))

node_trace.marker.color = node_adj

fig = go.Figure(data=[edge_trace, node_trace],
             layout=go.Layout(
                title='Networkx + yaml + Python',
                titlefont_size=16,
                showlegend=False,
                hovermode='closest',
                margin=dict(b=20,l=5,r=5,t=40),
                xaxis=dict(showgrid=False, zeroline=False, showticklabels=False),
                yaxis=dict(showgrid=False, zeroline=False, showticklabels=False))
                )
fig.show()