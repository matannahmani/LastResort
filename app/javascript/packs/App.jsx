// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, {Component, useState, useEffect} from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Tabs from 'components/tabs';
import Myfriends from 'components/myfriends';
import Searchfriend from 'components/searchfriend';

class App extends Component {
  request = async (url) =>
    {
      let response = await fetch(`${location.origin}/${url}`);
      let data = await response.json()
      if (data.code === 200 && data.msg === 'Success index'){
        this.setState({value:0,data: data.friends})
      }
      else if (data.code === 200){
        console.log(data)
        this.setState({value:this.state.value,data: data.data})
      }
    }
    postData = async (url, data) => {
      // Default options are marked with *
      const response = await fetch(`${location.origin}/${url}`, {
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'same-origin', // include, *same-origin, omit
        headers: {
          'Content-Type': 'application/json'
          // 'Content-Type': 'application/x-www-form-urlencoded',
        },
        redirect: 'follow', // manual, *follow, error
        referrerPolicy: 'no-referrer', // no-referrer, *client
        body: JSON.stringify(data) // body data type must match "Content-Type" header
      });
      return await response.json(); // parses JSON response into native JavaScript objects
    }

  state = {
    data: [],
    value: 0
  };
  componentDidMount(){
    this.request('/friends');
  }
  getState = (value) => {
    switch (value) {
      case 0:
        this.setState({value: 0,data: []})
        this.request('friends');
        break;
      case 1:
        this.setState({value: 1,data: []});
        this.request('/friends/randomfriends');
        break;
      case 2:
        this.setState({value: 2,data: []});
        this.request('/friends/friendrequests');
    }
  }
  searchState = (value) => {
    this.request(`/friends/search/${value}`);
  }
  addFriendHandler = (name) => {
    console.log(name);
    this.postData('/friends/add',{name: name}).then((response) =>
    {
      if (response.code === 200){
        alert(response.data)
        this.setState({value: this.state.value, data: this.state.data.filter ( (i) => i[1] !== name)})
      }
      else
        alert(response.msg)
    });
  }
  acceptFriendHandler = (name,status) => {
    console.log(name,status);
    this.postData('/friends/acceptfriend',{nickname: name,accept: status}).then((response) =>
    {
      if (response.code === 200){
        alert(response.data)
        this.setState({value: this.state.value, data: this.state.data.filter ( (i) => i[1] !== name)})
      }
      else
        alert(response.msg)
    });
  }
    render () { // Needs to be implemented in class-based components! Needs to return some JSX!
      let person;
      let search = null;
      if (this.state.data.constructor === Array || this.state.data.constructor === Object )
      person = this.state.data.map((person) => <Myfriends key={person[1]} name={person[1]} acceptFriend={this.acceptFriendHandler}title={person[2].title} addFriend={this.addFriendHandler} value={this.state.value}/>)
      if (this.state.value === 1) {
          search = <Searchfriend sendSearch={this.searchState}/>;
          console.log(person)
     }
    return (
        <div>
        <Tabs sendState={this.getState} />
        {search}
        {person}
        <a href={`${location.origin}/games/main`}>Go back</a>
        </div>
    );
  }
}
export default App
