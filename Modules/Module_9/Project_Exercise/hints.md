# Module 9 Project Exercise Hints

Are you seeing any of the below issues?

### I can't connect to the DB

<details markdown="1">
<summary markdown="1">
On a Mac and getting an error containing "SSL: CERTIFICATE_VERIFY_FAILED"?
</summary>

Here's the solution:

- Install the "certifi" package: `poetry add certifi` on command line
- Import it in your Python file: `import certifi`
- When you create your MongoClient, point it to certifi: `client = MongoClient(<connection_string>, tlsCAFile=certifi.where())`

<details markdown="1">
<summary markdown="1">
Explanation of the issue
</summary>

When connecting over SSL (or technically TLS), the server presents a certificate to prove their identity. This certificate has been signed by a "certificate authority" (or "CA") which in turn is signed by a higher authority and so on up a chain. At the top will be a "root CA" not signed by anyone else. 

In order to trust the server's certificate, you need a store of trusted CAs. If your trust store contains the root CA (or any of the other certificates in the chain), then you trust the server's certificate and can happily proceed with a secure request. 

The [certifi](https://pypi.org/project/certifi/) package contains Mozilla's curated list of trustworthy CAs, so we're just telling pymongo to use that to validate its connection to your database server.

</details>

</details>
