module.exports = (robot) ->
  robot.respond /meme (.*) with (.*) and (.*)/i, (res) ->
    memeType = res.match[1]
    lineOne = res.match[2]
    lineTwo = res.match[3]
    data = {
      username: YOUR USERNAME HERE,
      password: YOUR PASSWORD HERE,
      'text1' : lineTwo,
      'text0' : lineOne
    }
    switch memeType
      when "batman" then data.template_id = 438680
      when "aliens" then data.template_id = 101470
      when "interesting man" then data.template_id = 61532
      when "fry" then data.template_id = 61520
      else data.template_id = 61579
    console.log( data )
    res.http("https://api.imgflip.com/caption_image")
      .header('Content-Type', 'application/json')
      .post(data) (err, resp, body) ->
        if err
          res.send "Malfunction :( #{err}"
          return
        else
          meme = JSON.parse body
          console.log( body )
          if meme.success is true
            res.send body.data.url
            return
          else
            res.send "imgflip error :( #{body}"
            return

  robot.respond /chuck norris me/i, (res) ->
    res.http("http://api.icndb.com/jokes/random?limitTo=[nerdy]")
      .get() (err, resp, body ) ->
        joke = JSON.parse body
        if joke.type is 'success'
          res.send joke.value.joke
        else
          res.send "Chuck Norris API is too good for you"

  robot.respond /ron swanson me/i, (res) ->
    res.http("http://ron-swanson-quotes.herokuapp.com/v2/quotes")
    .get() (err, resp, body ) ->
      if err
        res.send "https://media.giphy.com/media/FDNvFxC2udLFu/giphy.gif"
        return
      else
        res.send body

  robot.respond /yes or no/i, (res) ->
    res.http("http://yesno.wtf/api/")
    .get() (err, resp, body ) ->
      if err
        res.send "https://media.giphy.com/media/FDNvFxC2udLFu/giphy.gif"
        return
      else
        console.log( body )
        answer = JSON.parse body
        res.send "#{answer.answer}! #{answer.image}"
