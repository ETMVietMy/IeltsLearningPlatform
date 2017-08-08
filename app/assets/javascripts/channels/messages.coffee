jQuery(document).ready ->
  if typeof user_id != 'undefined'
    App.messages = App.cable.subscriptions.create {channel: "MessagesChannel", user: user_id},
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        console.log data
        console.log data: data
        html = """
        <div class="notification alert alert-info">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <p>#{data.content}</p>
        </div>
        """
        console.log html
        $('body').append html

      test: (data) ->
        this.perform 'test', {message: data}

      notify: (receiver) -> 
        this.perform 'notify', {receiver: receiver}