import React, { Component } from 'react';
import BigCalendar from 'react-big-calendar';
import "react-big-calendar/lib/css/react-big-calendar.css";
import moment from 'moment';
import events from './events';


BigCalendar.momentLocalizer(moment);

export default class Calendar extends Component {
  constructor(props) {
    super(props)
    this.state = { events: events };
    BigCalendar.setLocalizer(
      BigCalendar.momentLocalizer(moment)
    );
  }

  render() {
    const min = new Date();
       min.setHours(8);
       min.setMinutes(0, 0, 0);

    const max = new Date();
       max.setHours(20);
       max.setMinutes(0, 0, 0);

    return (
      <div style={{width: 600}}>
        <BigCalendar
          {...this.props}
          events={this.state.events}
          defaultView="week"
          defaultDate={new Date(2017, 10, 29)}
          views={{ week: true }}
          step={15}
          timeslots={4}
          min={min}
          max={max}
          selectable
        />
      </div>
    );
  }
}
