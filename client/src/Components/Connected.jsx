import React from "react";

const Connected = (props) => {
    return (
        <div className="connected-container">
            <h1 className="connected-header">Your Account is connected</h1>
            <p className="connected-account">Metamask Account: {props.account}</p>
            
        </div>
    )
}

export default Connected;