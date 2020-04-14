import bottle

#  general exposures query endpoint
@bottle.get('/v1/general_exposures')
def index():
  query = bottle.request.query.q
  
  return {"success": query}
