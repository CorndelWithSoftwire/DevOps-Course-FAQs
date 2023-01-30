# MiniKube Project Exercise Hints

<details markdown="1">
<summary markdown="1">
How to debug issues with my pods?
</summary>

The first approach is likely to be checking the status of your pods - do they exist, are they crashing, or do they think they're running happily?
`kubectl get pods`

If you see an issue like `ErrImageNeverPull` then that suggests that your deployment isn't finding the container image it was expecting; check that your `deployment.yaml` exactly matches the image name that you loaded with `minikube image load ...`. You may be able to derive more information with `kubectl describe pods <pod_name>`.

If the pod is crashing, checking its logs can be a sensible next step:
`kubectl logs <pod_name>`

If the pod is running but you are seeing errors and the logs aren't helping, you can access a shell within your pod directly similarly to connecting to a Docker container locally:
```
kubectl exec -it <pod_name> -- bash
```

You can then explore, check that the container contains the right files etc.

</details>

<details markdown="1">
<summary markdown="1">
Pods seem happy but I can't access the site
</summary>

The primary thing to check in this case is whether you're making the pods accessible at the right addresses/ports. Check whether:
* Your `containerPort` value matches the port your app actually runs on
  * If you set the port dynamically, have you set a value with your environment variables?
* Your service's `targetPort` matches the container port you specified above
* Your service's `port` matches the right hand side of your port-forward command; for example, if you're using `kubectl port-forward service/module-14 7080:80` then check the service's port is 80
* You're visiting the expected address; with the above command you'd expect to visit `http://localhost:7080` in your browser

If you're getting confused - there are lots of little pieces to line up there! - then you can always set all the ports to the same value; e.g. if your app runs on port 8000 by default, then just set all the port values to 8000 including in your port-forward command, and visit `http://localhost:8000`. If you're still seeing issues then it's likely an issue with your pod - finding the logs and looking at whether it's throwing errors is likely to be your next step.

</details>

<details markdown="1">
<summary markdown="1">
Deployment is using an old version of my image?
</summary>

If you have loaded multiple images with Minikube, just restarting may not be sufficient to force your deployment to pick up the latest.

Two options to resolve this quickly are:
* Deleting & recreating the deployment should force it to get the latest version of the image
* Load the image under a slightly different name, and update your deployment to use that name (and apply those changes)

If neither of those resolve the issue, it's likely that the image you're loading still has the same issue you're seeing - test the image outside of Minikube to diagnose what might be the issue.

</details>


<details markdown="1">
<summary markdown="1">
Secrets aren't working?
</summary>

You can diagnose issues with `kubectl describe secrets` to check the right names/keys are set, or to get the (base64 encoded values) you can get those with `kubectl get secret envvars -o json`. You can then take the encoded value and decode those from a bash shell with `echo '<value>' | base64 -d`.

Setting secrets from the command line can be fiddly - if you'd rather have a more permanent way to store the secrets then create a `secrets.yaml` file like that below and apply that - don't forget to check it into your `.gitignore` so that you don't accidentally commit secrets to your source control! The values are base64 *encoded* - they are not encrypted and anyone can recover the raw values!

To base64 encode your values first, from a bash shell you can run `echo '<secret_value>' | base64` (alternatively you could use `https://www.base64encode.org/` - although for real secrets we should be very careful about posting them into unknown tools!)

```yml
apiVersion: v1
kind: Secret
metadata:
  name: envvars
type: Opaque
data:
  # values need to be base64 encoded
  secret_key: c2VjcmV0LWtleQo=

# If you separate your secrets into multiple secrets (as well as or instead of separate keys) then you can add more in the same file like:
---
apiVersion: v1
kind: Secret
metadata:
   ...

```

</details>