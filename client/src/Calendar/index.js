import React, { Component } from 'react';
import BigCalendar from 'react-big-calendar';
import HTML5Backend from 'react-dnd-html5-backend'
import { DragDropContext } from 'react-dnd'
import withDragAndDrop from 'react-big-calendar/lib/addons/dragAndDrop';
import moment from 'moment';
import "react-big-calendar/lib/css/react-big-calendar.css";

import ConfirmDeleteDialog from '../ConfirmDeleteDialog';

BigCalendar.momentLocalizer(moment);
const DragAndDropCalendar = withDragAndDrop(BigCalendar);

class Calendar extends Component {
  constructor(props) {
    super(props)
    this.state = {
      deleteDialogOpen: false
    };
    BigCalendar.setLocalizer(
      BigCalendar.momentLocalizer(moment)
    );

    this.minHour = new Date();
       this.minHour.setHours(8);
       this.minHour.setMinutes(0, 0, 0);

    this.maxHour = new Date();
       this.maxHour.setHours(20);
       this.maxHour.setMinutes(0, 0, 0);
  }

  addEvent = (event) => {
    this.setState({
      events: [...this.state.events, event]
    })
  }

  componentWillRecieveProps(newEvent) {
    if (!this.state.events.include(newEvent)) {
      this.addEvent(newEvent)
    }
  }

  deleteDialog = (event) => {
    this.setState(prevState => ({
      deleteDialogOpen: !prevState.deleteDialogOpen
    }));
  }

  saveEvent = slotInfo => {
    const { addEvent } = this.props
    const newEvent = {
      title: "Busy",
      start: slotInfo.start,
      end: slotInfo.end,
    }
    addEvent([newEvent])
  }

  render() {
    return (
      <div style={{width: 1000}}>
        <DragAndDropCalendar
          {...this.props}
          defaultView="week"
          defaultDate={new Date("May 1, 2017")}
          views={{ week: true }}
          step={15}
          timeslots={4}
          min={this.minHour}
          max={this.maxHour}
          selectable
          onSelectEvent={this.deleteDialog}
          onSelectSlot={this.saveEvent}
          onEventDrop={this.props.moveEvent}
        />
        {this.state.deleteDialogOpen
          ? <ConfirmDeleteDialog onDelete={this.props.deleteEvent} />
          : <div />}
      </div>
    );
  }
}

export default DragDropContext(HTML5Backend)(Calendar)
