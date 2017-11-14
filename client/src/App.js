import React, { Component } from "react";
import Search from "./Search";
import Calendar from "./Calendar";
import Results from "./Results";
import MuiThemeProvider from "material-ui/styles/MuiThemeProvider";

import './App.css'

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      term: "",
      events: [],
    };
  }

  addEvent = newEvents => {
    this.setState({
      events: [...this.state.events, ...newEvents]
    })
  }

  moveEvent = ({ event, start, end }) => {
    const { events } = this.state;

    const index = events.indexOf(event);
    const updatedEvent = { ...event, start, end };

    const updatedEvents = [...events]
    updatedEvents.splice(index, 1, updatedEvent)

    this.setState({
      events: updatedEvents
    })
  }

  deleteEvent = (event) => {
    const { events } = this.state;

    const index = events.indexOf(event);

    const updatedEvents = [...events]
    updatedEvents.splice(index, 1)

    this.setState({
      events: updatedEvents
    })
  }

  onSearchSubmit = (term) => {
    this.setState({ term });
  }

  render() {
    const { term } = this.state;

    let results = [
      { name: "CMPSC 40", times: "M W 2:00 p.m - 3:15 p.m" },
      { name: "CMPSC 56", times: "T R 9:30 a.m - 10:45 a.m" },
      { name: "CMPSC 130A", times: "M W 9:30 a.m - 10:45 a.m" }
    ];

    return (
      <MuiThemeProvider>
        <div className='App-body'>
          <Calendar
            events={this.state.events}
            addEvent={this.addEvent}
            moveEvent={this.moveEvent}
            deleteEvent={this.deleteEvent}
          />
          <Search onSubmit={this.onSearchSubmit} />
          <Results
            filterTerm={term}
            results={results}
            addEvent={this.addEvent}
          />
        </div>
      </MuiThemeProvider>
    );
  }
}

export default App;
