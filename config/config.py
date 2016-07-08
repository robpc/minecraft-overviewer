import os

def playerIcons(poi):
    if poi['id'] == 'Player':
        poi['icon'] = "http://overviewer.org/avatar/%s" % poi['EntityId']
        return "Last known location for %s" % poi['EntityId']

worlds['minecraft'] = os.getenv('MINECRAFT_WORLD_DIR',"/home/minecraft/server/world")
outputdir = os.getenv('MINECRAFT_MAP_RENDER_DIR',"/home/minecraft/render/")

renders["day"] = {
    'world': 'minecraft',
    'title': 'Day',
    'rendermode': 'smooth_lighting',
    'markers': [dict(name="Players", filterFunction=playerIcons)]
}

renders["night"] = {
    'world': 'minecraft',
    'title': 'Night',
    'rendermode': 'smooth_night',
    'markers': [dict(name="Players", filterFunction=playerIcons)]
}
