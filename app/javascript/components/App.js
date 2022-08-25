import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import Home from './layout/Home'

const App = props => {
  return (
    <Fragment>
      <div className="text-right my-10">
        <h1 className="text-4xl font-bold uppercase">{props.title}</h1>
      </div>
      <Home />
    </Fragment>
  )
}

App.defaultProps = {
  name: 'David'
}

App.propTypes = {
  name: PropTypes.string
}

export default App