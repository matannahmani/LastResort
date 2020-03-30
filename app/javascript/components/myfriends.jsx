import React from 'react'

const myfriends = (props) => {
  console.log(props)
  let friend
  if (props.value === 1){
  friend =       <div className='friend-buttons'>
        <button className="btn-success m-1 p-1" onClick={() => props.addFriend(props.name,true)}>V</button>
      </div>
      }
  else if (props.value === 2){
    friend =       <div className='friend-buttons'>
          <button className="btn-success m-1 p-1" onClick={() => props.acceptFriend(props.name,'true')}>Y</button>
          <button className="btn-danger m-1 p-1" onClick={() => props.acceptFriend(props.name,'false')}>X</button>
        </div>
  }
  return (
      <div className='friend-card'>
      <h1>{props.name}</h1>
      <h2>{props.title}</h2>
      {friend}
      </div>
);
}

export default myfriends
