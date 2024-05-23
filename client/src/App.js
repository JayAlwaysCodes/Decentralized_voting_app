import { useState, useEffect} from 'react';
import {ethers} from 'ethers'; 
import {contractAbi, contractAddress} from './Constant/constant';
import Login from './Components/Login';
import './App.css';

function App() { 
  return (
    <div className="App">
      <Login />
    </div>
  );
}

export default App;
