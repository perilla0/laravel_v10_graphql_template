import React from 'react';
import * as ReactDOM from 'react-dom/client';
import { ApolloClient, InMemoryCache, ApolloProvider, gql } from '@apollo/client';
import App from './App';

const client = new ApolloClient({
    uri: 'http://localhost/graphql',
    cache: new InMemoryCache(),
});

// client.query({
//     query: gql`
        // query MyQuery {
        //     users(first: 10) {
        //         data {
        //             email
        //             id
        //             name
        //             updated_at
        //         }
        //     }
        // }
//     `,
// }).then((result) => console.log(result));

// Supported in React 18+
const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
    <ApolloProvider client={client}>
      <App />
    </ApolloProvider>,
  );