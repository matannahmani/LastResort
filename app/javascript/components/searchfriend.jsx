import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import SearchIcon from '@material-ui/icons/Search';
import IconButton from '@material-ui/core/IconButton';



export default function BasicTextFields(props) {
  const onSend = () =>
  {
    if (document.getElementById('filled-basic') !== null)
      props.sendSearch(document.getElementById('filled-basic').value)
  }
  return (
    <form className='search-form' noValidate autoComplete="off">
    <TextField id="filled-basic" label="Filled" variant="filled">
    </TextField>
    <IconButton id='btn-search' aria-label="search" onClick={onSend}>
       <SearchIcon/>
     </IconButton>
    </form>
  );
}
