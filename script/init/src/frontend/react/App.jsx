// Import everything needed to use the `useQuery` hook
import { useQuery, gql } from '@apollo/client';

const GET_USERS = gql`
    query MyQuery {
        users(first: 10) {
            data {
                email
                id
                name
                updated_at
            }
        }
    }
`;

function DisplayUsers() {
  const { loading, error, data } = useQuery(GET_USERS);

  // console.log(data);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error : {error.message}</p>;

  return data.users.data.map(({ email, id, name, updated_at }) => (
    <div 
      key={id}
      style={{ backgroundColor: '#ccc', padding: '10px', margin: '10px 10px' }}
    >
      <h3>Name: {name} [id: {id}]</h3>
      <p>Email: {email}</p>
      <p>Updated: {updated_at}</p>
    </div>
  ));
}

export default function App() {
  return (
    <div>
      <h2>My first Apollo app 🚀</h2>
      <br/>
      <DisplayUsers />
    </div>
  );
}
