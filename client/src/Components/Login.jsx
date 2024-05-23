import React from "react";

const Login = (props) => {
    return (
        <div className="login-container">
            <h1 className="welcome-message">Welcome to  PEOPLE DECIDES 2026</h1>
            <button className="login-button" onClick = {props.connectWallet}>Connect Your Metamask</button>
        </div>
    )
}

export default Login;